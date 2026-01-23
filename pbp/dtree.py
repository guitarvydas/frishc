#!/usr/bin/env python3
import sys
import subprocess
import os
from pathlib import Path
import glob

def check_for_span_error(filepath):
    """Check if 'span' appears in the file (indicates draw.io formatting issue)"""
    with open(filepath, 'r') as f:
        content = f.read()
        if 'span' in content:
            print('draw.io sometimes inserts "span" into port names (if word wrap and/or formatted text enabled)')
            print('this is an error, do not continue')
            print(f'turn off "word wrap" and "formatted text" options for each port in draw.io for "{filepath}"')
            return False
    return True

def main():
    if len(sys.argv) != 4:
        print(f"Usage: {sys.argv[0]} <working_dir> <pbp_dir> <name>", file=sys.stderr)
        sys.exit(1)
    
    # Get arguments
    wd = Path(sys.argv[1]).resolve()
    pbpd = Path(sys.argv[2]).resolve()
    name = sys.argv[3]
    
    # Remove out.* and *.json files in current directory
    for pattern in ['./out.*', './*.json']:
        for f in glob.glob(pattern):
            try:
                os.remove(f)
            except OSError:
                pass
    
    # Change to dtree directory
    dtree_dir = pbpd / 'dtree'
    os.chdir(dtree_dir)
    
    try:
        # Run das2json.mjs
        subprocess.run(
            ['node', str(pbpd / 'das' / 'das2json.mjs'), 'dtree-transmogrifier.drawio'],
            check=True
        )
        
        # Check for span error (replaces ./check-for-span-error.bash)
        if not check_for_span_error('dtree-transmogrifier.drawio.json'):
            sys.exit(1)
        
        # Run python main.py piped to splitoutput.js
        python_proc = subprocess.Popen(
            ['python', 'main.py', f"{pbpd}/", f"{name}.drawio", 'main', 'dtree-transmogrifier.drawio.json'],
            stdout=subprocess.PIPE
        )
        
        node_proc = subprocess.Popen(
            ['node', str(pbpd / 'kernel' / 'splitoutput.js')],
            stdin=python_proc.stdout,
            stdout=subprocess.PIPE
        )
        
        python_proc.stdout.close()
        node_proc.communicate()
        
        if python_proc.returncode != 0:
            sys.exit(python_proc.returncode)
        if node_proc.returncode != 0:
            sys.exit(node_proc.returncode)
        
        # Check for error file
        error_file = Path('out.✗')
        if error_file.exists():
            print()
            print(error_file.read_text())
            print()
            sys.exit(1)
        else:
            # Move output files to working directory
            Path('out.frish').rename(wd / f'{name}.frish')
            Path('out.py').rename(wd / f'{name}.py')
            sys.exit(0)
            
    except subprocess.CalledProcessError as e:
        sys.exit(e.returncode)
    except FileNotFoundError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()
