table 50122 "Auto Model"
{
    Caption = 'Vehicle Model';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Make Code"; Code[20])
        {
            Caption = 'Make Code';
            TableRelation = "Auto Make";

        }
        field(2; "Model Code"; Code[20])
        {
            Caption = 'Model Code';

        }
        field(10; "Descpription"; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK1; "Model Code", "Make Code")
        {
            Clustered = true;
        }
    }

}