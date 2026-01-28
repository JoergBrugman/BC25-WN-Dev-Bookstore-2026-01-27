pageextension 50105 "BSB Customer List" extends "Customer List"
{
    actions
    {
        addlast(processing)
        {
            action("BSB WN26 CustCheckPipeline")
            {
                Caption = 'CustCheckPipeline';
                ApplicationArea = All;
                Image = Process;

                trigger OnAction()
                var
                    WN26CustCheckPipeline: Codeunit "BSB Cust. Check Pipeline";
                begin
                    WN26CustCheckPipeline.ProcessPipeline(Rec);
                end;
            }
        }
        addafter(Category_Process)
        {
            group("BSB WN26 WhatsNew")
            {
                actionref(WN26CustCheckPipeline_Promoted; "BSB WN26 CustCheckPipeline") { }
            }
        }
    }
}