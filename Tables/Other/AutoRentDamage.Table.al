table 50128 "Auto Rent Damage"
{
    Caption = 'Auto Rent Damage';

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract Number';
            TableRelation = "Auto Rent Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line Number';
        }
        field(10; "Accident date"; Date)
        {
            Caption = 'Accodent Date';
        }
        field(11; "Description"; Text[100])
        {
            Caption = 'Accident Description';
        }
    }

    keys
    {
        key(PK1; "Contract No.", "Line No.")
        {
            Clustered = true;
        }
    }

}