pageextension 50104 "BSB Book List BookType Process" extends "BSB Book List"
{
    actions
    {
        addlast(Processing)
        {
            group("BSB Interface")
            {
                action("BSB ClassicImpl")
                {
                    Caption = ' Classic Impl.';
                    ApplicationArea = All;
                    Image = Process;
                    ToolTip = 'Klassische Umsetzung';

                    trigger OnAction()
                    var
                        BSBBookTypeHardcClasPr: Codeunit "BSB Book Type Hardcover Impl.";
                        BSBBookTypePaperbClasPr: Codeunit "BSB Book Type Paperback Impl.";
                        IsHandled: Boolean;
                    begin
                        OnBeforeHandleBook(Rec, IsHandled);
                        if IsHandled then
                            exit;

                        case Rec.Type of
                            "BSB Book Type"::Hardcover:
                                begin
                                    BSBBookTypeHardcClasPr.StartDeployBook();
                                    BSBBookTypeHardcClasPr.StartDeliverBook();
                                end;
                            "BSB Book Type"::Paperback:
                                begin
                                    BSBBookTypePaperbClasPr.StartDeployBook();
                                    BSBBookTypePaperbClasPr.StartDeliverBook();
                                end;
                        end;
                    end;
                }
                action("BSB InterfaceImpl")
                {
                    Caption = ' Interface Impl.';
                    ApplicationArea = All;
                    Image = Process;
                    ToolTip = 'Interface Umsetzung';

                    trigger OnAction()
                    var
                        BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                        BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                        BSBBookTypeDefaultImpl: Codeunit "BSB Book Type Default Impl.";
                        BSBBookTypeProcess: Interface "BSB Book Type Process";
                        IsHandled: Boolean;
                    begin
                        OnBeforeHandleBook(Rec, IsHandled);
                        if IsHandled then
                            exit;

                        case Rec.Type of
                            "BSB Book Type"::Hardcover:
                                BSBBookTypeProcess := BSBBookTypeHardcoverImpl;
                            "BSB Book Type"::Paperback:
                                BSBBookTypeProcess := BSBBookTypePaperbackImpl;
                            else
                                BSBBookTypeProcess := BSBBookTypeDefaultImpl;
                        end;
                        BSBBookTypeProcess.StartDeployBook();
                        BSBBookTypeProcess.StartDeliverBook();
                    end;
                }
                action("BSB EnumWithInterfaceImpl")
                {
                    Caption = 'Enum with Interface Impl.';
                    ApplicationArea = All;
                    Image = Process;
                    ToolTip = 'Enum mit Interface Umsetzung';

                    trigger OnAction()
                    var
                        BSBBookTypeProcess: Interface "BSB Book Type Process";
                    begin
                        BSBBookTypeProcess := Rec.Type;
                        BSBBookTypeProcess.StartDeployBook();
                        if BSBBookTypeProcess is "BSB Book Type Process V2" then
                            (BSBBookTypeProcess as "BSB Book Type Process V2").CheckBook();
                        BSBBookTypeProcess.StartDeliverBook();
                    end;
                }
            }
        }
        addlast(Promoted)
        {
            group("BSB WN25Interface")
            {
                Caption = 'WN25 Interface';
                actionref(BSBClassicImpl; "BSB ClassicImpl") { }
                actionref(BSBInterfaceImpl_Promoted; "BSB InterfaceImpl") { }
                actionref(BSBEnumWithInterfaceImpl_Promoted; "BSB EnumWithInterfaceImpl") { }
            }
        }
    }


    [IntegrationEvent(false, false)]
    local procedure OnBeforeHandleBook(Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}