namespace :dev do
  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :rebuild => [ "dev:build", "db:seed" ]
end

# 執行rake dev:build 即可把專案資料一切清空歸零重建
# 執行rake dev:rebuild 即可重建完後自動跑db:seed
