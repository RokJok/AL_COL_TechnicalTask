page 50131 "Finished Vehicle Contract List"
{
    Caption = 'Finished Vehicle Contracts';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header - Finished";

    CardPageId = "Finished Vehicle Contract Card";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Rent No."; Rec."Contract No.")
                {
                    ToolTip = 'Displays the number of the contract.';
                }
                field("Client No."; Rec."Customer No.")
                {
                    ToolTip = 'Displays the number of the customer.';
                }
                field("Drivers Licence"; Rec."Drivers Licence")
                {
                    ToolTip = 'Displays the dirvers licence of the customer.';
                }
                field("Date"; Rec.Date)
                {
                    ToolTip = 'Displays the date of the contract.';
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ToolTip = 'Displays the number of the rented vehicle.';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Displays the starting date of the reservation.';
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Displays the end date of the reservation.';
                }
                field("Total Sum"; Rec."Total Cost")
                {
                    ToolTip = 'Displays the total cost of the reservation.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PrintReport)
            {
                Caption = 'Print';
                ToolTip = 'Print';
                Image = PrintReport;

                trigger OnAction()
                var
                    RentContract: Record "Auto Rent Header - Finished";
                begin
                    RentContract := Rec;
                    RentContract.SetRecFilter();
                    Report.RunModal(Report::"Auto Rent Contract Report", true, false, RentContract);
                end;
            }
        }
    }
}