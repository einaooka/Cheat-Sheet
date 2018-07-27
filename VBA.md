https://www.soa.org/News-and-Publications/Newsletters/Compact/2012/january/com-2012-iss42-roper.aspx

1. Turn off automatic spreadsheet calculation

```vba
Application.Calculation = xlCalculationManual

Calculate ' Global Update
Worksheets("sheet1").Calculate ' Only a specific sheet
Range("A1:C5").Calculate ' Only a range

Application.Calculation = xlCalculationAutomatic.
```

2. Turn off screen updates
```
Application.ScreenUpdating = FALSE

Application.ScreenUpdating = TRUE
```

3. Minimize traffic between VBA and the worksheet

4. Read and write blocks of data in a single operation

```vba
Dim myArray() As Variant ' note that this must be a variant
myArray= Worksheets("Sheet1").Range("A1:Z100").value
```

5. Avoid using certain Excel worksheet functions

```vba
Function Max2 (Value1, Value2) 
If Value1 > Value2 Then
Max2 = Value1
Else
Max2 = Value2
End If
End Function
```

6. Avoid using Variants in formulas

7. Avoid evaluating Strings

```vba
Select Case Gender
Case "Male"
'(insert code here)...
Case "Female"
'(insert code here)...
Case "Unisex"
'(insert code here)...
End Select
```
Or by enumeration
```vba
Public Enum enumGender
Male = 0
Female = 1
Unisex = 2
End Enum
Dim Gender as enumGender

Select Case Gender
Case Male
(insert code here)...
Case Female
(insert code here)...
Case Unisex
(insert code here)...
End Select
```

Boolean operators are simply TRUE or FALSE switches that process really quickly. In the example below bMale, bFemale and bUnisex are Boolean variables. The Boolean code is roughly 10 times faster than using Strings.

8. Don't select specific worksheets unless necessary

Avoid this:
```vba
Worksheets("sheet1").Select
Amount1 = Cells(1, 1)
```
Do this instead:
```vba
Amount1 = Worksheets("sheet1").Cells(1,1)
```

9. Avoid overuse of StatusBar updates

```vba
For scenario = 1 To 10000
(insert code here)...
If Scenario mod 100 = 0 Then Application.StatusBar = Scenario
Next Scenario
```

10. Avoid unnecessary math

11. Don't Copy and Paste

Use instead
```vba
Range("A1:Z100").value = Range("A101:Z200").value
```

12. Check computational time

```vba
'**Evaluate the first function
Start_time = Now
For i = 1 To 1000000
value1 = Application.Max(amt1, amt2)
Next i
End_time = Now
Worksheets("sheet1").Cells(1, 2) = End_Time — Start_Time

'**Evaluate the second function
Start_time = Now
For i = 1 To 1000000
value1 = Max2(amt1, amt2)
Next i
End_time = Now
Worksheets("sheet1").Cells(2, 2) = End_Time — Start_Time
```

