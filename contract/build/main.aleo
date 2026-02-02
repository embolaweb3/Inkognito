program inkognito.aleo;

record DiaryEntry:
    owner as address.private;
    id as u64.private;
    category as u8.private;
    timestamp as u32.private;
    line1 as u128.private;
    line2 as u128.private;
    line3 as u128.private;
    line4 as u128.private;

record SharedEntry:
    owner as address.private;
    sender as address.private;
    timestamp as u32.private;
    line1 as u128.private;
    line2 as u128.private;

function create_entry:
    input r0 as u64.private;
    input r1 as u8.private;
    input r2 as u32.private;
    input r3 as u128.private;
    input r4 as u128.private;
    input r5 as u128.private;
    input r6 as u128.private;
    cast self.caller into r7 as address;
    cast r7 r0 r1 r2 r3 r4 r5 r6 into r8 as DiaryEntry.record;
    output r8 as DiaryEntry.record;

function update_entry:
    input r0 as DiaryEntry.record;
    input r1 as u8.private;
    input r2 as u32.private;
    input r3 as u128.private;
    input r4 as u128.private;
    input r5 as u128.private;
    input r6 as u128.private;
    cast self.caller into r7 as address;
    cast r7 r0.id r1 r2 r3 r4 r5 r6 into r8 as DiaryEntry.record;
    output r8 as DiaryEntry.record;

function delete_entry:
    input r0 as DiaryEntry.record;

function share_entry:
    input r0 as DiaryEntry.record;
    input r1 as address.private;
    cast r1 self.caller r0.timestamp r0.line1 r0.line2 into r2 as SharedEntry.record;
    cast r0.owner r0.id r0.category r0.timestamp r0.line1 r0.line2 r0.line3 r0.line4 into r3 as DiaryEntry.record;
    output r3 as DiaryEntry.record;
    output r2 as SharedEntry.record;
