codeunit 50102 "BSB This-Demo Client"
{
    procedure ThisClientProcedure(BSBThisDemo: Codeunit "BSB This-Demo")
    begin
        Message('In Client-CU: %1', BSBThisDemo.GetStateVar());
        BSBThisDemo.SetStateVar('Level 3 (aus Client)');
        Message('In Client-CU: %1', BSBThisDemo.GetStateVar());
    end;
}