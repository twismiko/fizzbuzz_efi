#include<efi.h>
#include<efilib.h>

EFI_STATUS
efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
{
	  InitializeLib(ImageHandle, SystemTable);
	    Print(L"Fizzbuzz on UEFI!\n");
	    for(i = 1; i < 100; i++)
	    {
		if(i % 3 == 0 && i % 5 == 0)
		{
		 	Print(L"FizzBuzz(%d),", i);	
		}else if(i % 3 == 0){
			Print(L"Fizz(%d),", i);
		}else if(i % 5 == 0){
			Print(L"Buzz(%d),", i);
		}else{
			Print(L"%d(%d),", i,i);
		}

	    }
	        
	      return EFI_SUCCESS;
}
