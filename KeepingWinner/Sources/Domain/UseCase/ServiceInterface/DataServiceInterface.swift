// MARK: - v1.0 이후 데이터 관리 방식
protocol RecordDataServiceInterface {
  /// 모든 기록을 불러옵니다
  func readAllRecord(baseballTeams: [BaseballTeamModel], stadiums: [StadiumModel]) -> Result<[RecordModel], Error>
  /// 새로운 기록을 저장합니다
  func saveRecord(_ record: RecordModel) -> Result<VoidResponse, Error>
  /// 기존의 기록을 수정합니다
  func editRecord(_ record: RecordModel) -> Result<VoidResponse, Error>
  /// 기존의 기록을 삭제합니다
  func removeRecord(id: UUID) -> Result<VoidResponse, Error>
}
