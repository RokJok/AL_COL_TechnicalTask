codeunit 50122 "Return Vehicle"
{
    TableNo = "Auto Rent Header";

    trigger OnRun()
    var
        AutoReturnedMsg: Label 'Vehicle returned.';
    begin
        CreateFinishedContract(Rec);
        //TransferAutoDamage(Rec);
        DeleteRentContract(Rec."Contract No.");
        Message(AutoReturnedMsg);
    end;

    local procedure CreateFinishedContract(RentContract: Record "Auto Rent Header")
    var
        CH: Record "Auto Rent Header"; // CH - Contract Header
        CL: Record "Auto Rent Line"; // CL - Contract Line
        FinishedCH: Record "Auto Rent Header - Finished";
        FinishedCL: Record "Auto Rent Line - Finished";
    begin

        FinishedCH.TransferFields(RentContract);
        FinishedCH.Insert(true);
        FinishedCH.Modify(true);

        CL.SetFilter("Contract No.", RentContract."Contract No.");
        if CL.FindSet() then begin
            repeat
                FinishedCL.TransferFields(CL);
                FinishedCL.Insert(true);
                FinishedCL.Modify(true);
            until CL.Next() = 0;
        end;
    end;

    local procedure TransferAutoDamage(RentContract: Record "Auto Rent Header") //Not working
    var
        PrevDamageRec: Record "Auto Damage";
        CurDamageRec: Record "Auto Rent Damage";
        LineNo: Integer;
    begin
        CurDamageRec.SetFilter("Contract No.", RentContract."Contract No.");
        if CurDamageRec.FindSet() then begin
            PrevDamageRec.SetFilter("Vechicle No.", RentContract."Auto No.");
            if PrevDamageRec.FindLast() then begin
                LineNo := PrevDamageRec."Line No.";
            end
            else
                LineNo := 1;
            PrevDamageRec.Reset();
            repeat

                PrevDamageRec."Vechicle No." := RentContract."Auto No.";
                PrevDamageRec."Line No." := LineNo + 1;

                PrevDamageRec."Accident date" := CurDamageRec."Accident date";
                PrevDamageRec.Description := CurDamageRec.Description;

                PrevDamageRec.Insert(true);
                PrevDamageRec.Modify(true);
            until CurDamageRec.Next() = 0;
        end;
    end;

    local procedure DeleteRentContract(ContractNo: Code[20])
    var
        CurCHRec: Record "Auto Rent Header";
        CurCLRec: Record "Auto Rent Line";
        ReservationsRec: Record "Auto Reservations";
    begin
        CurCLRec.SetFilter("Contract No.", ContractNo);
        if CurCLRec.FindSet() then
            CurCLRec.DeleteAll();

        CurCHRec.SetRange("Contract No.", ContractNo);
        if CurCHRec.FindFirst() then begin
            ReservationsRec.SetFilter("Auto Number", CurCHRec."Auto No.");
            if ReservationsRec.FindSet() then
                ReservationsRec.Delete();
            CurCHRec.Delete();
        end;

    end;
}