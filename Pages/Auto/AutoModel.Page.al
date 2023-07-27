page 50122 "Auto Model"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Model";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Make Code"; Rec."Make Code")
                {
                    ToolTip = 'The code of the vechicle make';
                }
                field("Model Code"; Rec."Model Code")
                {
                    ToolTip = 'The code of the vechicles model';
                }
                field(Descpription; Rec.Descpription)
                {
                    ToolTip = 'Description and additional comments';
                }
            }
        }
    }

}