page 50121 "Auto Make"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Make";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto Make Code"; Rec."Auto Make Code")
                {
                    ToolTip = 'The code of the vechicle make';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description and additional comments';
                }
            }
        }
    }

}