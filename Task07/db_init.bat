	
 
echo "Starting database initialization process..."


# Загружаем SQL скрипт в базу данных
echo "Loading SQL script into database..."
sqlite3 university.db < db_init.sql

if [ $? -eq 0 ]; then
    echo "Database initialization completed successfully!"
    echo "Database file: university.db"
    
    # Проверяем созданные таблицы
    echo "Created tables:"
    sqlite3 university.db ".tables"
else
    echo "Error: Database initialization failed!"
    exit 1
fi
