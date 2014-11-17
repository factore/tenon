class RemoveDispatchesAndDelayedJobs < ActiveRecord::Migration
  def change
    drop_table :tenon_delayed_jobs
    drop_table :tenon_dispatches
  end
end
