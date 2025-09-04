rule wannacry {
    meta:
        author = "Alex Macenas"
        date_created = "July 04, 2024"
        malware_source = "TCM Security's Practical Malware Analysis & Triage"

    strings:
        $host_based_indicators_1 = "@wannadecryptor@"
        $host_based_indicators_2 = "@Please_Read_Me@"
        $PE_magic_byte = "MZ"
        $smb = "SMB"
        $file_extension = ".wnry"

    condition:
        any of ($host_based_indicators_1, $host_based_indicators_2, $smb, $file_extension) and $PE_magic_byte
}
