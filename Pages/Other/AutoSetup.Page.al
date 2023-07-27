
page 50120 "Auto Setup"
{
    Caption = 'Auto Setup';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Auto Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Contract Nos"; Rec."Auto Nos")
                {
                    ToolTip = 'Auto No Series';
                }
                field("Rent Card Nos"; Rec."Rent Card Nos")
                {
                    ToolTip = 'Rent Card No Series';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}