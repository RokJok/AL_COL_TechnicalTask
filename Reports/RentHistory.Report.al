report 50121 "Rent History Report"
{
    Caption = 'Vehicle Rent History';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Auto; Auto)
        {
            PrintOnlyIfDetail = true;
            column(Auto_Number; "Auto Number")
            {
            }
            column(Auto_Make; "Auto Make")
            {
            }
            column(Auto_Model; "Auto Model")
            {
            }
            dataitem("Auto Rent Header - Finished"; "Auto Rent Header - Finished")
            {
                DataItemLink = "Auto No." = field("Auto Number");
                DataItemTableView = sorting("Contract No.");

                column(Contract_No_; "Contract No.")
                {
                }
                column(Customer_No; "Customer No.")
                {
                }
                column(ReservedFrom; "Reserved From")
                {

                }
                column(ReservedUntil; "Reserved Until")
                {
                }

                dataitem("Auto Rent Line - Finished"; "Auto Rent Line - Finished")
                {
                    DataItemLink = "Contract No." = field("Contract No.");
                    DataItemTableView = sorting("Contract No.", "Line No.");
                    column(Total_Amount; "Total Amount")
                    {
                    }
                }
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = field("Customer No.");
                    DataItemTableView = sorting("No.");

                    column(Name; Name)
                    {
                    }
                }
                trigger OnPreDataItem()
                begin
                    SetFilter("Reserved From", '1%..', StartDate);
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartDateCrtl; StartDate)
                    {
                        Caption = 'Start date filter';
                    }
                    field(EndDateCtrl; EndDate)
                    {
                        Caption = 'End date filter';
                    }
                }
            }
        }
    }


    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layout\VehicleRentContract2.rdl';
        }
    }

    var
        StartDate: Date;
        EndDate: Date;

    trigger OnInitReport()
    begin
        StartDate := WorkDate();
    end;

    trigger OnPreReport()
    var
        NoStartDateErr: Label 'Start date filter is not selected';
    begin
        if StartDate = 0D then
            Error(NoStartDateErr);
    end;
}