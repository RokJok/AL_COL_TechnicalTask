table 50125 "Auto Damage"
{
    Caption = 'Auto Damage';

    fields
    {
        field(1; "Vechicle No."; Code[20])
        {
            Caption = 'Vehicle Number';
            TableRelation = Auto;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line Number';
        }
        field(10; "Accident date"; Date)
        {
            Caption = 'Accident Date';
        }
        field(11; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(12; "Status"; Enum "Auto Damage Status")
        {
            Caption = 'Damage Status';
        }
    }

    keys
    {
        key(PK1; "Vechicle No.", "Line No.")
        {
            Clustered = true;
        }
    }

}