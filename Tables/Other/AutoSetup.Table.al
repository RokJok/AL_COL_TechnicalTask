table 50120 "Auto Setup"
{
    Caption = 'Auto Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Auto Nos"; Code[20])
        {
            Caption = 'Auto NoSeries';
            TableRelation = "No. Series";
        }
        field(11; "Rent Card Nos"; Code[20])
        {
            Caption = 'Rent Card NoSeries';
            TableRelation = "No. Series";
        }
        field(12; "Addon Location"; Code[10])
        {
            Caption = 'Addon Location';
            TableRelation = Location;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Primary Key") { }
        fieldgroup(Brick; "Primary Key") { }
    }

    trigger OnInsert()
    begin
        InitDefaultValues();
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

    local procedure InitDefaultValues()
    begin
    end;
}