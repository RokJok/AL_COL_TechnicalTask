table 50121 "Auto Make"
{
    Caption = 'Vehicle Make';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto Make Code"; Code[20])
        {
            Caption = 'Make Code';
        }
        field(10; "Description"; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Auto Make Code")
        {
            Clustered = true;
        }
    }
}