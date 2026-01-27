codeunit 50101 "BSB This-Demo"
{
    trigger OnRun()
    begin
        SetStateVar('Level 1');
        Message('In ursprünglicher CU: %1', GetStateVar());
        CallThisProcedure(this);
        Message('In ursprünglicher CU: %1', GetStateVar());
        BSBThisDemoClient.ThisClientProcedure(this);
        Message('In ursprünglicher CU: %1', GetStateVar());
    end;

    procedure SetStateVar(Txt: Text)
    begin
        StateVar := txt;
    end;

    procedure GetStateVar(): Text
    begin
        exit(StateVar);
    end;

    local procedure CallThisProcedure(ThisDemoCodeunit: Codeunit "BSB This-Demo")
    begin
        Message('In Referenz-CU: %1', ThisDemoCodeunit.GetStateVar());
        ThisDemoCodeunit.SetStateVar('Level 2');
        Message('In Referenz-CU: %1', ThisDemoCodeunit.GetStateVar());
    end;

    var
        BSBThisDemoClient: Codeunit "BSB This-Demo Client";
        StateVar: Text;
}