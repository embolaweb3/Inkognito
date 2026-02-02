program inkognito.aleo {
    record DiaryEntry {
        owner: address,
        id: u64,
        category: u8,    // 1: Personal, 2: Work, 3: Health, etc.
        timestamp: u32,
        line1: u128,
        line2: u128,
        line3: u128,
        line4: u128,
    }

    record SharedEntry {
        owner: address,      // The recipient
        sender: address,     // The original author
        timestamp: u32,
        line1: u128,
        line2: u128,
    }


    // Create a private entry
    transition create_entry(
        id: u64, 
        category: u8,
        timestamp: u32, 
        line1: u128, 
        line2: u128,
        line3: u128,
        line4: u128
    ) -> DiaryEntry {
        return DiaryEntry {
            owner: self.caller as address,
            id: id,
            category: category,
            timestamp: timestamp,
            line1: line1,
            line2: line2,
            line3: line3,
            line4: line4,
        };
    }

    // Update an existing entry
    transition update_entry(
        old_entry: DiaryEntry, 
        new_category: u8,
        new_timestamp: u32,
        new_l1: u128, 
        new_l2: u128,
        new_l3: u128,
        new_l4: u128
    ) -> DiaryEntry {
        return DiaryEntry {
            owner: self.caller as address,
            id: old_entry.id,
            category: new_category,
            timestamp: new_timestamp,
            line1: new_l1,
            line2: new_l2,
            line3: new_l3,
            line4: new_l4,
        };
    }

    // Delete an entry
    transition delete_entry(entry: DiaryEntry) {
        // Record is consumed here
    }

    // Share an entry with another user
    transition share_entry(
        entry: DiaryEntry, 
        recipient: address
    ) -> (DiaryEntry, SharedEntry) {
        
        // Create the shared copy for the recipient
        let shared_copy = SharedEntry {
            owner: recipient,
            sender: self.caller,
            timestamp: entry.timestamp,
            line1: entry.line1,
            line2: entry.line2,
        };

        let original_back = DiaryEntry {
            owner: entry.owner,
            id: entry.id,
            category: entry.category,
            timestamp: entry.timestamp,
            line1: entry.line1,
            line2: entry.line2,
            line3: entry.line3,
            line4: entry.line4,
        };

        return (original_back, shared_copy);
    }
}