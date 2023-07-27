page 50135 "Auto Damage"
{
    Caption = 'Vechicle Damage List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Damage";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Vechicle No."; Rec."Vechicle No.")
                {
                    ToolTip = 'Specifies the Vechicle Number.';
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status of the damages';
                }
            }
        }
    }
}