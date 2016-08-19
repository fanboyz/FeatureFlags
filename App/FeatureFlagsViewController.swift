//
//  FeatureFlagsViewController.swift
//  FeatureFlags
//
//  Created by Sean Henry RP on 18/08/2016.
//  Copyright © 2016 Rise Project. All rights reserved.
//

import UIKit

class FeatureFlagsViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    private var featureFlags = [FeatureFlag]()
    private var featureFlagFile: NSURL!
    private var fetcher: FeatureFlagFetcher!
    private var persister: FeatureFlagPersister!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        load()
        setUpBackgroundNotification()
        adjustInsets()
    }
    
    private func setUpBackgroundNotification() {
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationDidBecomeActiveNotification, object: nil, queue: nil) { _ in
            self.load()
        }
    }
    
    private func adjustInsets() {
        tableView.contentInset = UIEdgeInsetsZero
        tableView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    private func load() {
        guard let file = FeatureFlagsLocation.defaultLocation else {
            showError()
            return
        }
        fetcher = PlistFeatureFlagFetcher(file: file)
        persister = PlistFeatureFlagPersister(file: file)
        featureFlags = fetcher.fetch()
        tableView.reloadData()
    }
    
    private func change(value value: Bool, atIndex index: Int) {
        featureFlags[index].value = value
        persister.persist(featureFlags)
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Error", message: "Not allowed access to the shared group directory.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension FeatureFlagsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureFlags.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as! SwitchCell
        let index = indexPath.row
        cell.name = featureFlags[index].name
        cell.value = featureFlags[index].value
        cell.delegate = self
        return cell
    }
}

extension FeatureFlagsViewController: SwitchCellDelegate {
    
    func cell(cell: SwitchCell, didChangeValue value: Bool) {
        guard let indexPath = tableView.indexPathForCell(cell) else { return }
        change(value: value, atIndex: indexPath.row)
    }
}
