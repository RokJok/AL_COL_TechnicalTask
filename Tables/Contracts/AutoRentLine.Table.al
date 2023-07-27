table 50127 "Auto Rent Line"
{
    Caption = 'Rent Contract Line';
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

            TableRelation =
                if ("Type" = const(Item)) Item
            else
            if ("Type" = const(Resource)) Resource;

            trigger OnValidate()
            var
                ItemRec: Record Item;
                ResourceRec: Record Resource;
            begin
                if Type = Type::Item then begin
                    ItemRec.Get("Item/Resource No.");

                    Description := ItemRec.Description;
                    "Unit Price" := ItemRec."Unit Price";
                end;
                if Type = Type::Resource then begin
                    ResourceRec.Get("Item/Resource No.");

                    Description := ResourceRec.Name;
                    "Unit Price" := ResourceRec."Unit Price";
                end;
            end;

        }
        field(12; "Description"; Text[100])
        {
            Caption = 'Description';
            TableRelation =
                if ("Type" = const(Item)) Item
            else
            if ("Type" = const(Resource)) Resource;
        }
        field(20; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                "Total Amount" := Round(Quantity * "Unit Price");
            end;
        }
        field(21; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';

            TableRelation =
                if ("Type" = const(Item)) Item
            else
            if ("Type" = const(Resource)) Resource;
        }
        field(22; "Total Amount"; Decimal)
        {
            Caption = 'Total amount';
            Editable = false;
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