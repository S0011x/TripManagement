//
//  CloudKitUsers.swift
//  TripManagement
//
//  Created by suha alrajhi on 12/10/1445 AH.
//

import SwiftUI
import CloudKit


class CloudKitUsersViewModel: ObservableObject{
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    init() {
        getiCloudStatus()
        requestPermission()
       fetchCloudUserRecordID()
    }
    
    private func getiCloudStatus(){
        CKContainer.default().accountStatus{ returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus{
                case .available:
                    self.isSignedInToiCloud = true
                case .noAccount:
                    self.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
                
            }
            
            
        }
    }
    
    
    enum CloudKitError: String, LocalizedError{
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
        
    }
    
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]){
            [weak self] returnedStatus, returnedError in DispatchQueue.main.async{
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    

    func fetchCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in if let id = returnedID {
            self?.discoveriCloudUser(id: id)
        }
            
        }
    }






    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async{
                if let name = returnedIdentity?.nameComponents?.givenName{
                    self?.userName = name
                }
            }
        }
    }
    
}

struct CloudKitUsers: View {
    @StateObject private var vm = CloudKitUsersViewModel()
    var body: some View {
        VStack{
            Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
            Text("Permission: \(vm.permissionStatus.description.uppercased())")
            Text ("NAME: \(vm.userName)")
        }
    }
}


#Preview {
    CloudKitUsers()
        
}
