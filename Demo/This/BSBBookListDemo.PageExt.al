pageextension 50102 "BSB Book List Demo" extends "BSB Book List"
{
    actions
    {
        addlast(Demo)
        {
            action("BSB ThisDemo")
            {
                Caption = 'This Demo';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the This Demo action';
                RunObject = codeunit "BSB This-Demo";
            }
        }
        addlast(DemoWN_Promoted)
        {
            actionref(BSBThisDemo; "BSB ThisDemo") { }
        }
    }
}