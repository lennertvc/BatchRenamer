#tag Class
Protected Class StuFinder
Inherits thread
	#tag Event
		Sub Run()
		  renameAllSTUs
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub constructor()
		  renamedCounter = 0
		  
		  // Return a resourceFolder based on the platform and build state
		  #if debugBuild then
		    #if TargetWindows then
		      baseFolder = app.ExecutableFile.Parent.Parent
		    #else
		      baseFolder = app.ExecutableFile.Parent.Parent.parent.Parent
		    #Endif
		  #else
		    #if TargetWindows then
		      baseFolder = app.ExecutableFile.Parent
		    #else
		      baseFolder = app.ExecutableFile.Parent.Parent.Parent
		    #Endif
		  #endif
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findInstallationDescription(f as folderItem) As String
		  dim installationDescription as String = ""
		  
		  dim parentFolder as folderItem = f.Parent
		  
		  while (installationDescription = "") and (parentFolder <> nil) and (parentFolder <> baseFolder)
		    
		    dim folderName as String =parentFolder.name
		    dim installationFolderPattern as String ="^(.*)\s-\s(\d\d\d\d)$"
		    
		    dim InstallationName as String =  foldername.Replace(installationFolderPattern, "$1", TRUE)
		    dim InstallationKP as String = folderName.Replace(installationFolderPattern, "$2", TRUE)
		    
		    if (InstallationName <> folderName) and (InstallationKP <> folderName) then
		      installationDescription = "1"+installationKP.pad(5,"0")+" "+InstallationName
		    else
		      parentFolder=parentFolder.parent
		    end if
		    
		  wend
		  
		  return installationDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub renameAllSTUs()
		  renamedCounter = 0
		  
		  dim subDirectoriesToSearch() as folderitem = Array(baseFolder)
		  
		  while (subDirectoriesToSearch.Ubound >= 0) 
		    
		    dim currentDirectory as folderItem = subDirectoriesToSearch(0)
		    
		    for i as Integer=1 to currentDirectory.Count
		      dim currentItem as FolderItem = currentDirectory.TrueItem(i)
		      
		      if not currentItem.Alias then
		        
		        if currentItem.Directory then
		          subDirectoriesToSearch.Append(currentItem)
		        else
		          
		          if Right(currentItem.name, 4) = ".stu"  then
		            RenameSingleSTU(currentItem)
		          end if
		          
		        end if
		        
		      end if
		      
		    next
		    
		    subDirectoriesToSearch.Remove(0)
		    
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub renameSingleSTU(f as FolderItem)
		  dim oldName as String = f.Name
		  dim oldPath as String = f.NativePath
		  dim installationDescription as String = findInstallationDescription(f)
		  
		  if installationDescription <> "" then
		    
		    dim PLCName as String = "PLC01"
		    
		    // Try to find existing PLC-number
		    dim PLCNumber as String = oldName.Replace(".*PLC[ -_]?(\d)+.*", "$1",TRUE)
		    if PLCNumber<> oldName then
		      PLCName = "PLC"+PLCNumber.pad(2,"0")
		    else
		      system.DebugLog("PLC number : "+ PLCNumber)
		    end if
		    
		    // Do the actual renaming
		    dim newName as String =  installationDescription+", "+PLCName+".stu"
		    f.Name = newName
		    renamedCounter = renamedCounter+1
		    system.DebugLog("File "+oldPath+" werd herbenoemd naar "+newName)
		    
		  else
		    system.DebugLog("File "+oldPath+" kon niet worden herbenoemd")
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub selectBaseFolder()
		  Dim dlg As New SelectFolderDialog
		  dlg.ActionButtonCaption = "Selecteer"
		  dlg.PromptText = "Selecteer een map"
		  dlg.InitialDirectory = SpecialFolder.Desktop
		  
		  Dim f As FolderItem
		  f = dlg.ShowModal
		  If f <> Nil Then
		    app.stuFinder.baseFolder = f
		  Else
		    // User cancelled
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		baseFolder As folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		renamedCounter As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="renamedCounter"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
