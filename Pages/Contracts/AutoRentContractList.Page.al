page 50126 "Vehicle Rent Contract List"
{
    Caption = 'Vehicle Rent Contract';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header";

    CardPageId = "Vehicle Rent Contract Card";
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
                field(Status; Rec."Contract Status")
                {
                    ToolTip = 'Displays the status of the contract.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ReleaseContract)
            {
                Caption = 'Release';
                ToolTip = 'Release contract';
                Image = ReleaseDoc;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"Contract Status Management", Rec);
                end;
            }
            action(OpenContract)
            {
                Caption = 'Open';
                ToolTip = 'Open contract';
                Image = ReOpen;

                trigger OnAction()
                var
                    ContractManagement: Codeunit "Contract Status Management";
                begin
                    ContractManagement.OpenContract(Rec);
                end;
            }
            action(OpenReservationList)
            {
                Caption = 'Open Reservation List';
                ToolTip = 'Opens the reservation list';
                Image = OpenWorksheet;

                trigger OnAction()
                var
                    ReserveList: Page "Auto Reservations";
                begin
                    ReserveList.Run();
                end;
            }
            action(ReturnVehicle)
            {
                Caption = 'Return Vehicle';
                ToolTip = 'Finalizes the rent contract: creates a finished contract and moves the damages done to the vehicle information part';
                Image = Completed;

                trigger OnAction()
                var
                    ReturnVehicle: Codeunit "Return Vehicle";
                    ContractOpenErr: Label 'Contract needs to be released before the vehicle is returned';
                begin
                    if (Rec."Contract Status" = Rec."Contract Status"::Released) then begin
                        ReturnVehicle.Run(Rec);
                    end
                    else
                        Error(ContractOpenErr);
                end;
            }
        }
    }
}