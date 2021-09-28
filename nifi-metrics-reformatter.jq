# グループ情報
def processGroupData:
  {
  "activeThreadCount": .activeThreadCount,
  "bytesIn": .bytesIn,
  "bytesOut": .bytesOut,
  "bytesQueued": .bytesQueued,
  "bytesRead": .bytesRead,
  "bytesReceived": .bytesReceived,
  "bytesSent": .bytesSent,
  "bytesTransferred": .bytesTransferred,
  "bytesWritten": .bytesWritten,
  "flowFilesIn": .flowFilesIn,
  "flowFilesOut": .flowFilesOut,
  "flowFilesQueued": .flowFilesQueued,
  "flowFilesReceived": .flowFilesReceived,
  "flowFilesSent": .flowFilesSent,
  "flowFilesTransferred": .flowFilesTransferred,
  "id": .id,
  "input": .input,
  "name": .name,
  "output": .output,
  "queued": .queued,
  "queuedCount": .queuedCount,
  "queuedSize": .queuedSize,
  "read": .read,
  "received": .received,
  "sent": .sent,
  "terminatedThreadCount": .terminatedThreadCount,
  "transferred": .transferred,
  "written": .written
  }
;

# コネクション情報
def connectionData:
  {
  "bytesIn": .bytesIn,
  "bytesOut": .bytesOut,
  "bytesQueued": .bytesQueued,
  "destinationName": .destinationName,
  "flowFilesIn": .flowFilesIn,
  "flowFilesOut": .flowFilesOut,
  "flowFilesQueued": .flowFilesQueued,
  "groupId": .groupId,
  "id": .id,
  "input": .input,
  "name": .name,
  "output": .output,
  "percentUseBytes": .percentUseBytes,
  "percentUseCount": .percentUseCount,
  "queued": .queued,
  "queuedCount": .queuedCount,
  "queuedSize": .queuedSize,
  "sourceName": .sourceName
  }
;

# プロセッサ情報
def processorData:
  {
  "activeThreadCount": .activeThreadCount,
  "bytesIn": .bytesIn,
  "bytesOut": .bytesOut,
  "bytesRead": .bytesRead,
  "bytesWritten": .bytesWritten,
  "executionNode": .executionNode,
  "flowFilesIn": .flowFilesIn,
  "flowFilesOut": .flowFilesOut,
  "groupId": .groupId,
  "id": .id,
  "input": .input,
  "name": .name,
  "output": .output,
  "read": .read,
  "runStatus": .runStatus,
  "taskCount": .taskCount,
  "tasks": .tasks,
  "tasksDuration": .tasksDuration,
  "tasksDurationNanos": .tasksDurationNanos,
  "terminatedThreadCount": .terminatedThreadCount,
  "type": .type,
  "written": .written
  }
;

# 再帰でネスト構造を解析
def analyze:
 [.connectionStatusSnapshots[].connectionStatusSnapshot | connectionData]
 + [.processorStatusSnapshots[].processorStatusSnapshot | processorData]
 + [ processGroupData ]
 + ([.processGroupStatusSnapshots[].processGroupStatusSnapshot | analyze] | reduce .[] as $item ([]; . + $item))
;

# Top階層のみ構造が違うので構造を合わせるTop解析
def convertNestedFormat:
 .processGroupStatus.aggregateSnapshot | analyze
;

convertNestedFormat
