## First Version

Started by creating everything in a single module. In this single module we have:

1. a fake hash with three entries mapping the {point_to_start, amount_of_bytes_to_read};
2. an insert function that takes a key/value pair and persists to a segment file;
3. a get function that take a key and, so far, returns the whole entry "someKey:someValue"


## Second version

[] Implement a Writer GenServer (or similar) for receiving the write requests. Only one process will handle it.

[] Implement a SegmentProvider GenServer. There can be many SegmentProviders. Each provider will contain a HashTable GenServer and Segment GenServer. The `Segment Provider` should be able to answer what's the most recent segment. Delet the non-used and son on.

[] Implement a Merger process. The merger process will execute when a specific threshold is achieved. It can be how many Segements exist or can be a periodic time. The Merger will let the `SegmentProvider` whe it's merging segments because the SegmentProvier will provision another segment for writing.

## Third version

[] Implement a memtable

[] Refactor reads to get from memtable before gettingin touch with the file;

[] Refactor the writer to write to memtable and flush in a specific threshold;

[] Implement a Bloom filter.
