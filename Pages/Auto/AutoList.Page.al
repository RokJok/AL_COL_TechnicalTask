page 50123 "Auto List"
{
    Caption = 'Vehicle List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Auto;

    CardPageId = "Auto Card";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto Number"; Rec."Auto Number")
                {
                    ToolTip = 'Specifies the Vehicle Number.';
                }
                field("Auto Name"; Rec."Auto Name")
                {
                    ToolTip = 'Specifies the Vehicle Name.';
                }
                field("Auto Make"; Rec."Auto Make")
                {
                    ToolTip = 'Specifies the Make of the Vehicle.';

                }
                field("Auto Model"; Rec."Auto Model")
                {
                    ToolTip = 'Specifies the Model of the Vehicle.';
                }
                field("Model year"; Rec."Model year")
                {
                    ToolTip = 'Specifies the Vehicles model year.';
                }
                field("Insurance date"; Rec."Insurance date")
                {
                    ToolTip = 'Specifies the expiration date of the vehicles insurance.';
                }
                field("Technical Inspection"; Rec."Technical Inspection")
                {
                    ToolTip = 'Specifies the expiration date of the vehicles Technical Inspection.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location of the vehicle.';
                }
                field("Rental Program"; Rec."Rental Program")
                {
                    ToolTip = 'Specifies the rent program of the vehicle.';

                }
                field("Rental cost"; Rec."Rental cost")
                {
                    ToolTip = 'Specifies the rental cost of the vehicle.';

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
                Caption = 'Print Rent History';
                ToolTip = 'Prints the rent history of all vehicles.';
                Image = PrintReport;

                trigger OnAction()
                begin
                    Report.RunModal(Report::"Rent History Report", true, false);
                end;
            }
        }
    }
}