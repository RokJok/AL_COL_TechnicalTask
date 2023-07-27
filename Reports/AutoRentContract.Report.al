report 50120 "Auto Rent Contract Report"
{
    Caption = 'Vehicle Rent Contract';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Auto Rent Header - Finished"; "Auto Rent Header - Finished")
        {
            column(Contract_No; "Contract No.")
            {
            }
            column(Auto_No_; "Auto No.")
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
                column(ItemResourceNo_AutoRentLineFinished; "Item/Resource No.")
                {
                }
                column(Description_AutoRentLineFinished; Description)
                {
                }
                column(Quantity_AutoRentLineFinished; Quantity)
                {
                }
                column(UnitPrice_AutoRentLineFinished; "Unit Price")
                {
                }
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

            dataitem(Auto; Auto)
            {
                DataItemLink = "Auto Number" = field("Auto No.");
                DataItemTableView = sorting("Auto Number");
                column(Auto_Make; "Auto Make")
                {

                    IncludeCaption = true;
                }
                column(Auto_Model; "Auto Model")
                {
                    IncludeCaption = true;
                }
            }

        }
    }


    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layout\VehicleRentContract.rdl';
        }
    }

}