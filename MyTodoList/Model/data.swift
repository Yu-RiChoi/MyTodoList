//
//  data.swift
//  MyTodoList
//
//  Created by 최유리 on 1/8/24.
//

import Foundation

// 사용자 정의 타입의 경우 인코딩이 필요하므로 Codable 프로토콜 채택
struct Todo: Codable {
    var title: String
    var isCompleted: Bool
}

