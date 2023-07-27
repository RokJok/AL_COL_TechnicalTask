page 50128 "Vehicle Rent Contract Card"
{
    Caption = 'Vehicle Rent Contract';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Auto Rent Header";


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Rent No."; Rec."Contract No.")
                {
                    ToolTip = 'Displays the number of the contract.';
                    Editable = Rec."Contract Status" = Rec."Contract Status"::Open;
                }
                field("Client No."; Rec."Customer No.")
                {
                    ToolTip = 'Displays the number of the customer.';
                    Editable = Rec."Contract Status" = Rec."Contract Status"::Open;
                }
                field("Drivers Licence"; Rec."Drivers Licence")
                {
                    ToolTip = 'Displays the dirvers licence of the customer.';
                    Editable = Rec."Contract Status" = Rec."Contract Status"::Open;
                    Visible = true;

                }
                field("Date"; Rec.Date)
                {
                    ToolTip = 'Displays the date of the contract.';
                    Editable = Rec."Contract Status" = Rec."Contract Status"::Open;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ToolTip = 'Displays the number of the rented vehicle.';
                    Editable = Rec."Contract Status" = Rec."Contract Status"::Open;
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Displays the starting date of the reservation.';
                    Editable = Rec."Contract Status" = Rec."Contract Status"::Open;
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Displays the end date of the reservation.';
                    Editable = Rec."Contract Status" = Rec."Contract Status"::Open;
                }
                field("Total Sum"; Rec."Total Cost")
                {
                    ToolTip = 'Displays the total cost of the reservation.';
                    Editable = false;
                }
                field(Status; Rec."Contract Status")
                {
                    ToolTip = 'Displays the status of the contract.';
                    Editable = false;
                }
            }
            part(Lines; "Auto Contract SubPage")
            {
                SubPageLink = "Contract No." = field("Contract No.");
                Editable = Rec."Contract Status" = Rec."Contract Status"::Open;

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

            action(ImportLicense)
            {
                Caption = 'Import License';
                ToolTip = 'Imports an image of the drivers license.';
                Image = Import;

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec."Drivers Licence".ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(DeleteLicense)
            {
                Caption = 'Delete License';
                ToolTip = 'Deletes the image of the drivers license.';
                Image = Delete;

                trigger OnAction()
                begin
                    if Rec."Drivers Licence".HasValue then begin
                        Clear(Rec."Drivers Licence");
                        Rec.Modify(true);
                    end;

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