page 50130 "Auto Rent Damage"
{
    Caption = 'Vehicle Rent Damage';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Damage";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the Contract Number.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the Line Number.';
                }
                field("Accident date"; Rec."Accident date")
                {
                    ToolTip = 'Specifies the date of the accident.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the accident.';
                }
            }
        }
    }
}