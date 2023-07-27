table 50130 "Auto Rent Line - Finished"
{
    Caption = 'Finished Vehicle Rent Line';
    DataClassification = CustomerContent;

    fields
    {

        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; "Type"; Enum "Rent Line Type")
        {
            Caption = 'Type';
        }
        field(11; "Item/Resource No."; Code[20])
        {
            Caption = 'Unit Number';
        }
        field(12; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(20; Quantity; Decimal)
        {
            Caption = 'Quantity';

        }
        field(21; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(22; "Total Amount"; Decimal)
        {
            Caption = 'Total amount';
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