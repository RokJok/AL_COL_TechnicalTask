table 50129 "Auto Rent Header - Finished"
{
    Caption = 'Finished Vehicle Contract';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract Number';
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer Number';

        }
        field(11; "Drivers Licence"; Media)
        {
            Caption = 'Cutomers Drivers Licence';
        }
        field(12; "Date"; Date)
        {
            Caption = 'Contract Date';
        }
        field(13; "Auto No."; Code[20])
        {
            Caption = 'Vehicle Number';
        }
        field(14; "Reserved From"; Date)
        {
            Caption = 'Reserved From';
        }
        field(15; "Reserved Until"; Date)
        {
            Caption = 'Reserved Until';
        }
        field(16; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            Editable = false;

            FieldClass = FlowField;
            CalcFormula =
                sum("Auto Rent Line - Finished"."Total Amount"
                    where("Contract No." = field("Contract No.")));

        }
    }

    keys
    {
        key(PK1; "Contract No.")
        {
            Clustered = true;
        }
    }


}