codeunit 50108 "BSB Cust. Check Blocked" implements "BSB Cust. Check Step"
{
    procedure Execute(Customer: Record Customer): Text
    begin
        if Customer.Blocked <> "Customer Blocked"::" " then
            Exit(StrSubstNo('100: Customer is blocked in level %1', Customer.Blocked));
    end;

    procedure GetSequence(): Integer
    begin
        exit(100);
    end;

    procedure IsEnabled(Customer: Record Customer): Boolean
    begin
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BSB Cust. Check Pipeline", OnRegisterCustCheckSteps, '', false, false)]
    local procedure "BSB Cust. Check Pipeline_OnRegisterCustCheckSteps"(Steps: List of [Interface "BSB Cust. Check Step"])
    begin
        Steps.Add(this);
    end;
}