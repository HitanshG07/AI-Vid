import json, yaml, glob

with open('assets/manifest.json', 'r', encoding='utf-8') as f:
    manifest = json.load(f)

for path in sorted(glob.glob('stories/_inbox/*.yaml')):
    with open(path, 'r', encoding='utf-8') as f:
        data = yaml.safe_load(f)
    
    s_set = data.get('set')
    set_spots = set(manifest['sets'][s_set]['spots'].keys())
    cast_names = {c['name'] for c in data.get('cast', [])}
    
    print(f'=== Technical deep dive for {path} ===')
    errors = []
    
    # check cast
    for c in data.get('cast', []):
        c_name = c.get('name')
        if c.get('spot') and c['spot'] not in set_spots:
            errors.append(f"Cast {c_name} invalid spot {c['spot']}")
        if c.get('gender') not in manifest['genders']:
            errors.append(f"Cast {c_name} invalid gender {c['gender']}")
        if c.get('default_face') not in manifest['faces']:
            errors.append(f"Cast {c_name} invalid face {c['default_face']}")
            
    # check beats
    for i, b in enumerate(data.get('beats', [])):
        b_num = i + 1
        if b.get('cam') not in manifest['cameras']:
            errors.append(f"Beat {b_num} invalid cam {b.get('cam')}")
        if b.get('motion') not in manifest['motions']:
            errors.append(f"Beat {b_num} invalid motion {b.get('motion')}")
        if b.get('target') not in cast_names:
            errors.append(f"Beat {b_num} target {b.get('target')} not in cast")
        if b.get('action') not in manifest['actions']:
            errors.append(f"Beat {b_num} invalid action {b.get('action')}")
        if b.get('face') not in manifest['faces']:
            errors.append(f"Beat {b_num} invalid face {b.get('face')}")
        if b.get('speaker') not in manifest['speakers']:
            errors.append(f"Beat {b_num} invalid speaker {b.get('speaker')}")
        if b.get('sfx') and b['sfx'] not in manifest['active_sfx']:
            errors.append(f"Beat {b_num} invalid sfx {b.get('sfx')}")
        if b.get('spot') and b['spot'] not in set_spots:
            errors.append(f"Beat {b_num} invalid spot {b.get('spot')}")
        if b.get('snap_spot') and b['snap_spot'] not in set_spots:
            errors.append(f"Beat {b_num} invalid snap_spot {b.get('snap_spot')}")
        if b.get('move_to') and b['move_to'] not in set_spots:
            errors.append(f"Beat {b_num} invalid move_to {b.get('move_to')}")
        if 'badge' in b:
            errors.append(f"Beat {b_num} has floating badge")
        for w in b.get('with', []):
            if w.get('name') not in cast_names:
                errors.append(f"Beat {b_num} with target {w.get('name')} not in cast")
            if w.get('action') and w['action'] not in manifest['actions']:
                errors.append(f"Beat {b_num} with invalid action {w.get('action')}")
            if w.get('face') and w['face'] not in manifest['faces']:
                errors.append(f"Beat {b_num} with invalid face {w.get('face')}")
            if w.get('spot') and w['spot'] not in set_spots:
                errors.append(f"Beat {b_num} with invalid spot {w.get('spot')}")
            if w.get('snap_spot') and w['snap_spot'] not in set_spots:
                errors.append(f"Beat {b_num} with invalid snap_spot {w.get('snap_spot')}")
                
    if errors:
        for e in errors:
            print('  ERR:', e)
    else:
        print('  All manifest technical checks passed!')
