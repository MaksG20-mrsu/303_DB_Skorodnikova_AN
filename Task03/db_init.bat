	
 
echo "Starting database initialization process..."

# Проверяем наличие PowerShell
if command -v pwsh &> /dev/null; then
    POWERSHELL_CMD="pwsh"
elif command -v powershell &> /dev/null; then
    POWERSHELL_CMD="powershell"
else
    echo "Error: PowerShell is not installed or not in PATH"
    echo "Please install PowerShell"
    exit 1
fi

# Проверяем наличие sqlite3
if ! command -v sqlite3 &> /dev/null; then
    echo "Error: sqlite3 is not installed or not in PATH"
    exit 1
fi

# Запускаем PowerShell скрипт для генерации SQL
echo "Generating SQL script using PowerShell..."
$POWERSHELL_CMD -ExecutionPolicy Bypass -File "sqript.ps1"

if [ $? -ne 0 ]; then
    echo "Error: SQL script generation failed!"
    exit 1
fi

# Загружаем SQL скрипт в базу данных
echo "Loading SQL script into database..."
sqlite3 movies_rating.db < db_init.sql

if [ $? -eq 0 ]; then
    echo "Database initialization completed successfully!"
    echo "Database file: movies_rating.db"
    
    # Проверяем созданные таблицы
    echo "Created tables:"
    sqlite3 movies_rating.db ".tables"
else
    echo "Error: Database initialization failed!"
    exit 1
fi
