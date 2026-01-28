page 50103 "BSB External Storage"
{
    Caption = 'BC26WN External Storage';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action(ExportToFileStorage)
            {
                Caption = 'Export to Storage';
                Image = Export;
                ToolTip = 'Executes the Export to Storage action.';

                trigger OnAction()
                var
                    ExternalFileStorage: Codeunit "External File Storage";
                    FileManagement: Codeunit "File Management";
                    InStr: InStream;
                    FileName, NameOnly, Extension : Text;
                    FilePath: Text;
                begin
                    if not UploadIntoStream('Select File', '', 'All Files (*.*)|*.*', FileName, InStr) then
                        exit;

                    NameOnly := FileManagement.GetFileNameWithoutExtension(FileName);
                    Extension := FileManagement.GetExtension(FileName);
                    ExternalFileStorage.Initialize(Enum::"File Scenario"::BC26WhatsNew);
                    FilePath := ExternalFileStorage.SaveFile('', NameOnly, Extension, 'Save as');
                    ExternalFileStorage.CreateFile(FilePath, InStr)
                end;
            }
        }
        area(Navigation)
        {
            action(FileAccounts)
            {
                Caption = 'File Accounts';
                Image = Account;
                ToolTip = 'Executes the File Accounts action.';
                RunObject = page "File Accounts";
            }
        }
    }
}