page 50124 "Auto Reservations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservations";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto Number"; Rec."Auto Number")
                {
                    ApplicationArea = All;
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
}