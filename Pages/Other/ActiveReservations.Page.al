page 50125 "Active Reservations"
{
    Caption = 'Active Reservations';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservations";

    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto Number"; Rec."Auto Number")
                {
                    ToolTip = 'Specifies the Vechicle Number.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the Line Number.';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Specifies the Customer Number.';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Specifies the starting date of the reservation.';
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Specifies the end date of the reservation.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Reserved From", '%1..', WorkDate());
    end;
}