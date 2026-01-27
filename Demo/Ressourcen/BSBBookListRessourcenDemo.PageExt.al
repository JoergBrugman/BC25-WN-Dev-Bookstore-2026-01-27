pageextension 50103 "BSB Book List Ressourcen Demo" extends "BSB Book List"
{
    actions
    {
        addlast(Demo)
        {
            action("BSB RessourcenListDemo")
            {
                Caption = 'Ressourcen List Demo';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Extecutes the Ressrcen List Demo';

                trigger OnAction()
                var
                    ResList: List of [Text];
                    Txt: Text;
                    TxtBuilder: TextBuilder;
                begin
                    ResList := NavApp.ListResources();
                    foreach Txt in ResList do
                        TxtBuilder.AppendLine(Txt);
                    Message(TxtBuilder.ToText());
                end;
            }
            action("BSB ResourceCSVDemo")
            {
                Caption = 'Ressource CSV Demo';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Extecutes the Resource CSV Demo';

                trigger OnAction()
                var
                    ResInStr: InStream;
                    Value: Text;
                begin
                    NavApp.GetResource('ProgrammingLanguages.csv', ResInStr);
                    while not ResInStr.EOS do begin
                        ResInStr.ReadText(Value);
                        Message(Value);
                    end;
                end;
            }
            action("BSB ResourcePNGDemo")
            {
                Caption = 'Resource PNG Demo';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Extecutes the Resource PNG Demo';
                trigger OnAction()
                var
                    Customer: Record Customer;
                    ResInStr: InStream;
                begin
                    NavApp.GetResource('Dynamics_365_Business_Central_logo.png', ResInStr);

                    Customer.Init();
                    Customer."No." := '';
                    Customer.Insert(true);
                    Customer.Image.ImportStream(ResInStr, 'Demo Picture');
                    Customer.Modify();
                    Page.Run(Page::"Customer Card", Customer);
                end;
            }
        }
        addlast(DemoWN_Promoted)
        {
            actionref(BSBRessourcenListDemo_Promoted; "BSB RessourcenListDemo") { }
            actionref(BSBResourceCSVDemo_Promoted; "BSB ResourceCSVDemo") { }
            actionref(BSBResourcePNGDemo_Promoted; "BSB ResourcePNGDemo") { }
        }
    }
}