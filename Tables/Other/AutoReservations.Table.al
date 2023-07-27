table 50124 "Auto Reservations"
{
    Caption = 'Vechicle Reservations';

    fields
    {
        field(1; "Auto Number"; Code[20])
        {
            TableRelation = Auto;
            Caption = 'Vehicle Number';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line Number';
        }
        field(10; "Client No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Client Number';
        }
        field(11; "Reserved From"; Date)
        {
            Caption = 'Reserved from';
            trigger OnValidate()
            var
                Reserved: Record "Auto Reservations";
            begin
                Reserved.Reset();
                Reserved.SetFilter("Auto Number", Rec."Auto Number");
                repeat
                    if (Rec."Reserved From" = Reserved."Reserved From") or
                    ((Rec."Reserved From" > Reserved."Reserved From") and (Rec."Reserved From" <= Reserved."Reserved Until")) then
                        Error('Not available');
                until Reserved.Next() = 0;
            end;
        }
        field(12; "Reserved Until"; Date)
        {
            Caption = 'Reserved until';
            trigger OnValidate()
            var
                Reserved: Record "Auto Reservations";
            begin
                Reserved.Reset();
                Reserved.SetFilter("Auto Number", Rec."Auto Number");
                repeat
                    if (Rec."Reserved Until" = Reserved."Reserved From") or
                    ((Rec."Reserved Until" > Reserved."Reserved From") and (Rec."Reserved Until" < Reserved."Reserved Until")) then
                        Error('Not available');
                until Reserved.Next() = 0;
            end;
        }
    }

    keys
    {
        key(PK1; "Auto Number", "Line No.")
        {
            Clustered = true;
        }
    }


}