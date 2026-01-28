codeunit 50110 "BSB Cust. Check ForeignBill" implements "BSB Cust. Check Step"
{
    procedure Execute(Customer: Record Customer): Text
    begin
        if Customer."Bill-to Customer No." <> '' then
            Exit(StrSubstNo('200: Foreign Customer must not have %1', Customer.FieldCaption("Bill-to Customer No.")));
    end;

    procedure GetSequence(): Integer
    begin
        exit(200);
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