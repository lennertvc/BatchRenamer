#tag Class
Protected Class StuFinder
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
		      installationDescription = installationKP.pad(6,"0")+" "+InstallationName
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
		      dim currentItem as FolderItem = currentDirectory.Item(i)
		      
		      if currentItem.Directory then
		        
		        subDirectoriesToSearch.Append(currentItem)
		        
		      else
		        
		        if Right(currentItem.name, 4) = ".stu"  then
		          RenameSingleSTU(currentItem)
		          renamedCounter = renamedCounter+1
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
		  dim installationDescription as String = findInstallationDescription(f)
		  
		  if installationDescription <> "" then
		    
		    dim PLCNumber as String = oldName.Replace(".*PLC[ -]?(\d)+.*", "$1",TRUE)
		    // dim programName as String = oldName.replace(".stu", "")
		    // programName = programName.replace(PLCNumber, "")
		    
		    // Do the actual renaming
		    f.Name = installationDescription+" "+"PLC"+PLCNumber.pad(2,"0")+".stu"
		    
		  else
		    system.DebugLog("File "+oldName+" kon niet worden herbenoemd")
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
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="renamedCounter"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
