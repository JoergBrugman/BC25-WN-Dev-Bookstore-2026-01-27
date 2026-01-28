codeunit 50107 "BSB Cust. Check Pipeline"
{
    procedure ProcessPipeline(Customer: Record Customer)
    var
        Step: Interface "BSB Cust. Check Step";
        Steps: List of [Interface "BSB Cust. Check Step"];
        TextBuilder: TextBuilder;
        ResultTxt: Text;
    begin
        CollectSteps(Steps);
        SortSteps(Steps);

        foreach Step in Steps do
            if Step.IsEnabled(Customer) then begin
                ResultTxt := Step.Execute(Customer);
                if ResultTxt <> '' then
                    TextBuilder.AppendLine(ResultTxt);
            end;
        if TextBuilder.Length() > 0 then
            Message(TextBuilder.ToText());
    end;

    local procedure CollectSteps(Steps: List of [Interface "BSB Cust. Check Step"])
    begin
        OnRegisterCustCheckSteps(Steps);
    end;

    local procedure SortSteps(Steps: List of [Interface "BSB Cust. Check Step"])
    var
        Integers: Record Integer;
        Sorted: List of [Interface "BSB Cust. Check Step"];
        Step: Interface "BSB Cust. Check Step";
    begin
        // Sequences einsammeln
        foreach Step in Steps do begin
            Integers.Get(Step.GetSequence());
            Integers.Mark(true);
        end;
        // Auf markierte Datensätze filtern 
        Integers.MarkedOnly(true);

        // Die Sequences nacheinander durchgehen
        if Integers.FindSet() then
            repeat
                // Alle Steps nacheinander durchgehen  
                foreach Step in Steps do
                    // Jetzt die Interfaces, die einer Sequence angehören, nacheinander übertragen
                    if Step.GetSequence() = Integers.Number then
                        Sorted.Add(Step);
            until Integers.Next() = 0;
        Steps := Sorted;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRegisterCustCheckSteps(Steps: List of [Interface "BSB Cust. Check Step"])
    begin
    end;
}