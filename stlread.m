function fv = stlread(filename)
% Simple STL reader for ASCII and binary STL files
% Returns a struct with fields 'faces' and 'vertices'

fid = fopen(filename,'r');
if fid == -1
    error('File could not be opened, check name or path.')
end

firstLine = fgetl(fid);
frewind(fid);

if contains(lower(firstLine),'solid')
    vertices = [];
    vertexCount = 0;
    faces = [];
    faceCount = 0;
    
    while ~feof(fid)
        tline = fgetl(fid);
        if contains(tline,'vertex')
            v = sscanf(tline,' vertex %f %f %f');
            vertices = [vertices; v'];
            vertexCount = vertexCount + 1;
        elseif contains(tline,'endfacet')
            faceCount = faceCount + 1;
        end
    end
    
    faces = reshape(1:vertexCount,3,[])';
else
    fseek(fid,80,'bof'); % skip header
    numFaces = fread(fid,1,'int32');
    
    vertices = zeros(numFaces*3,3);
    faces = zeros(numFaces,3);
    
    for i=1:numFaces
        fread(fid,3,'float32'); % normal vector ignored
        v1 = fread(fid,3,'float32')';
        v2 = fread(fid,3,'float32')';
        v3 = fread(fid,3,'float32')';
        fread(fid,1,'uint16'); % attribute byte count
        
        idx = (i-1)*3 + 1;
        vertices(idx,:) = v1;
        vertices(idx+1,:) = v2;
        vertices(idx+2,:) = v3;
        faces(i,:) = idx:idx+2;
    end
end
fclose(fid);

fv.faces = faces;
fv.vertices = vertices;
end
