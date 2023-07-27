page 50127 "Auto Contract SubPage"
{
    Caption = 'Vehicle Contract Lines';

    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Auto Rent Line";

    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Item/Resource No."; Rec."Item/Resource No.")
                {
                    ToolTip = 'Specifies the value of the Unit Number field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total amount field.';
                }
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        MandatoryLineErr: Label 'Can not delete - a rent program is mandatory';
    begin
        if Rec."Line No." = 1 then
            Error(MandatoryLineErr);
    end;
}