codeunit 50109 "BSB Cust. Check ForeignLoc" implements "BSB Cust. Check Step"
{
    procedure Execute(Customer: Record Customer): Text
    begin
        if Customer."Location Code" <> 'GELB' then
            Exit(StrSubstNo('50: Foreign Customer should have Location GELB and not %1', Customer."Location Code"));
    end;

    procedure GetSequence(): Integer
    begin
        exit(50);
    end;

    procedure IsEnabled(Customer: Record Customer): Boolean
    begin
        exit(Customer."Country/Region Code" <> '');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BSB Cust. Check Pipeline", OnRegisterCustCheckSteps, '', false, false)]
    local procedure "BSB Cust. Check Pipeline_OnRegisterCustCheckSteps"(Steps: List of [Interface "BSB Cust. Check Step"])
    begin
        Steps.Add(this);
    end;
}