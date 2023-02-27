Attribute VB_Name = "BarcodePrintMacros"
Function CallUserForm() As Object
' Create UserForm to get Date Update Selection

' Create dictionary to store results
Set CallUserForm = New Collection

'' Load Form
Load DateUpdateSelection

'' Set Default Values
' DateUpdateSelection.SetA.Value = True

' Display form to user
DateUpdateSelection.Show

'Save User Input
CallUserForm.Add Key:="SetA", Item:=DateUpdateSelection.SetA.Value
CallUserForm.Add Key:="SetB", Item:=DateUpdateSelection.SetB.Value

'' Unload Form
Unload DateUpdateSelection

End Function

Public Sub PrintLabel()

Dim ScannedString As String
Dim mydate As Date
Dim rng As Range


Do
    ' Scan the barcode first
    ScannedString = Application.InputBox(Prompt:="Scan the vial", Type:=2)
    
    ' If the string is empty, Exit Do
    
    If Len(ScannedString) = 0 Then
        Exit Do
    ElseIf StrPtr(ScannedString) = 0 Then
        'MsgBox ("User canceled!")
        Exit Do
    ElseIf ScannedString = vbNullString Then
        'MsgBox ("User didn't enter anything!")
        Exit Do
    End If
    
    ' Take out the ID from the scanned string
    'If Trim(ScannedString) = "" Then
    '    Exit Do
    'End If
        
    ' Search the ID
    With Sheets("Master List").Range("A:A")
            Set rng = .Find(What:=ScannedString, _
                            After:=.Cells(.Cells.Count), _
                            LookIn:=xlValues, _
                            LookAt:=xlWhole, _
                            SearchOrder:=xlByRows, _
                            SearchDirection:=xlNext, _
                            MatchCase:=False)
    End With
                            
    If rng Is Nothing Then
        MsgBox "No such ID"
        
    Else
        ' Copy the text from the ID
        Sheets("Labels").Range("A2") = rng.Value
        With Sheets("Labels").Range("A2")
            .Font.Name = "Calibri"
            .Font.Bold = True
            .Font.Size = 8
            .WrapText = False
            .VerticalAlignment = xlVAlignTop
        End With
        
        ' Generate a barcode for this entry
        Sheets("Labels").Range("A1") = "*" & rng.Value & "*"
        With Sheets("Labels").Range("A1")
            .Font.Name = "Free 3 of 9 Extended" 'Code 39 barcode font. This should be installed.
            .Font.Bold = False
            .Font.Size = 24 '18 30
            .HorizontalAlignment = xlCenter
            .VerticalAlignment = xlVAlignCenter
        End With
        
        
        ' Prompt user if which set of dates they would like to update
        Set Results = CallUserForm()
        
        ' Get current date
        mydate = Date
        
        If Results("SetA") = True Then
            ' Insert the most recently seen date.
            rng.Offset(0, 2) = mydate
            rng.Offset(0, 2).NumberFormat = "yyyy.m.d"
        End If
        If Results("SetB") = True Then
            ' Insert the most recently seen date.
            rng.Offset(0, 3) = mydate
            rng.Offset(0, 3).NumberFormat = "yyyy.m.d"
        End If
        
        ' Insert a date
        Sheets("Labels").Range("B2") = mydate
        With Sheets("Labels").Range("B2")
            .NumberFormat = "yyyy/mm/dd"
            .Font.Name = "Calibri"
            .Font.Bold = True
            .Font.Size = 8
            .HorizontalAlignment = xlRight
            .VerticalAlignment = xlVAlignCenter
        End With
        
        ' Copy INFO as a description
        Sheets("Labels").Range("A3") = rng.Offset(0, 1).Text
        With Sheets("Labels").Range("A3")
            .Font.Name = "Calibri"
            .WrapText = True
            .Font.Size = 6
            '.Range("B2").Font.Size = 4
            .VerticalAlignment = xlVAlignCenter
        End With
        
        ' Copy Type as a description
        Sheets("Labels").Range("B4") = rng.Offset(0, 4).Text
        With Sheets("Labels").Range("B4")
            .Font.Name = "Calibri"
            .Font.Bold = True
            .Font.Size = 8
            .WrapText = False
            .VerticalAlignment = xlVAlignCenter
        End With
    
        ' Print
        'Sheets("Labels").PrintPreview
        Sheets("Labels").PrintOut
    End If

Loop




End Sub


Public Sub PrintAllLabels()

Dim Counter As Integer
Dim mydate As Date
Dim rng As Range
Dim i As Integer, j As Integer


Dim IDrng As Range
Dim eachRng As Range


Counter = 0
i = Application.InputBox(Prompt:="Enter the FIRST row number", Type:=1)
j = Application.InputBox(Prompt:="Enter the LAST row number", Type:=1)

' Prompt user if which set of dates they would like to update
Set Results = CallUserForm()

Set IDrng = Worksheets("Master List").Range("A" & i & ":A" & j)

For Each eachRng In IDrng
    
                            
    If eachRng Is Nothing Then
        'MsgBox "No such ID"
        
    Else
        'MsgBox eachRng.Value
        
    
        With Sheets("Master List").Range("A:A")
            Set rng = .Find(What:=eachRng.Value, _
                            After:=.Cells(.Cells.Count), _
                            LookIn:=xlValues, _
                            LookAt:=xlWhole, _
                            SearchOrder:=xlByRows, _
                            SearchDirection:=xlNext, _
                            MatchCase:=False)
        End With
    

       ' Copy the text from the ID
        Sheets("Labels").Range("A2") = rng.Value
        With Sheets("Labels").Range("A2")
            .Font.Name = "Calibri"
            .Font.Bold = True
            .Font.Size = 8
            .WrapText = False
            .VerticalAlignment = xlVAlignTop
        End With
        
        ' Generate a barcode for this entry
        Sheets("Labels").Range("A1") = "*" & rng.Value & "*"
        With Sheets("Labels").Range("A1")
            .Font.Name = "Free 3 of 9 Extended" 'Code 39 barcode font. This should be installed.
            .Font.Bold = False
            .Font.Size = 24 '18 30
            .HorizontalAlignment = xlCenter
            .VerticalAlignment = xlVAlignCenter
        End With
        
        
        ' Get current date
        mydate = Date
        
        If Results("SetA") = True Then
            ' Insert the most recently seen date.
            rng.Offset(0, 2) = mydate
            rng.Offset(0, 2).NumberFormat = "yyyy.m.d"
        End If
        If Results("SetB") = True Then
            ' Insert the most recently seen date.
            rng.Offset(0, 3) = mydate
            rng.Offset(0, 3).NumberFormat = "yyyy.m.d"
        End If
        
        ' Insert a date
        Sheets("Labels").Range("B2") = mydate
        With Sheets("Labels").Range("B2")
            .NumberFormat = "yyyy/mm/dd"
            .Font.Name = "Calibri"
            .Font.Bold = True
            .Font.Size = 8
            .HorizontalAlignment = xlRight
            .VerticalAlignment = xlVAlignCenter
        End With
        
        
        ' Copy INFO as a description
        Sheets("Labels").Range("A3") = rng.Offset(0, 1).Text
        With Sheets("Labels").Range("A3")
            .Font.Name = "Calibri"
            .WrapText = True
            .Font.Size = 6
            '.Range("B2").Font.Size = 4
            .VerticalAlignment = xlVAlignCenter
        End With
        
        ' Copy Type as a description
        Sheets("Labels").Range("B4") = rng.Offset(0, 4).Text
        With Sheets("Labels").Range("B4")
            .Font.Name = "Calibri"
            .Font.Bold = True
            .Font.Size = 8
            .WrapText = False
            .VerticalAlignment = xlVAlignCenter
        End With
    
        ' Print
        'Sheets("Labels").PrintPreview
        Sheets("Labels").PrintOut
        
    End If

    'Counter = Counter + 1
    'If Counter > 8 Then
    '    Exit For
    'End If
        
Next




End Sub



