pageextension 50101 "BSB Customer List Ternary" extends "Customer List"
{
    layout
    {
        modify("Balance (LCY)")
        {
            StyleExpr = BalanceStyleExpr;
        }
    }

    trigger OnAfterGetRecord()
    begin
        BalanceStyleExpr := Rec."Balance (LCY)" > 0 ? Format(PageStyle::Favorable) : Format(PageStyle::None);
    end;

    var
        BalanceStyleExpr: Text;
}